#coding: utf-8
class TimelinesController < ApplicationController

  def index
    @timelines = Timeline.where(:kazoku_id => @current_user.kazoku.id).order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @timelines }
    end

  end
end
