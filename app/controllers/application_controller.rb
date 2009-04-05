#    News Sniffer
#    Copyright (C) 2007-2008 John Leach
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  helper :all
#  protect_from_forgery

  def get_random_comment
    @random_comment = HysComment.find(:all,
      :conditions => ['censored = 0 and updated_at < now() - INTERVAL 1 hour'], 
      :order => 'rand()', :limit => 1).first
  end

  def is_admin?
    session[:admin]
  end

  def check_admin
    unless is_admin?
      flash[:error] = "You must be logged in to do that."
      redirect_to :controller => 'admin', :action => 'login'
    end
    @admin_bar = true
  end
  
  def comment_permalink_url(comment)
    url_for(:controller => 'bbchysthreads', :action => 'show',
      :id => comment.hys_thread.bbcid, :comment_id => comment.bbcid, :anchor => comment.bbcid)
  end
                                
end