class VisitorsController < ApplicationController
    helper BookHelper
    def index
        @times = []
        unless params[:restaurant_name].nil? && params[:reserve_date].nil?
            @current_time = params[:reserve_date]
            @times = helpers.book_time(params[:restaurant_name], params[:reserve_date])
        else
            @current_time = Time.now.strftime('%m/%d/%Y')
        end
    end
end
