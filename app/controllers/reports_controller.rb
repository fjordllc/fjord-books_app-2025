# frozen_string_literal: true

require 'uri'

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    if @report.content.include?('http://localhost:3000/reports/')
      report_ids = report_ids_from_content(@report.content)

      report_ids.each do |mentioned_report_id|
        @report.report_mentions.build(mentioned_report_id: mentioned_report_id) if Report.exists?(mentioned_report_id)
      end
    end

    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!

    redirect_to reports_path, status: :see_other, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.expect(report: %i[user_id title content])
  end

  def report_ids_from_content(content)
    content.scan(%r{/reports/(\d+)}).flatten.map(&:to_i).uniq 
  end
end
