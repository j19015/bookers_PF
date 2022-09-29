class SearchesController < ApplicationController
  def search
    if params[:search_model].to_i==1#userの時
      if params[:search_method].to_i==1 #完全一致
        @users=User.where('name like ?',"#{params[:search_text]}")
      elsif params[:search_method].to_i==2#前方一致
        @users=User.where('name like ?',"#{params[:search_text]}%")
      elsif params[:search_method].to_i==3#後方一致
        @users=User.where('name like ?',"%#{params[:search_text]}")
      elsif params[:search_method].to_i==4#部分一致
        @users=User.where('name like ?',"%#{params[:search_text]}%")
      end
      render :search_user
    elsif params[:search_model].to_i==2#bookの時
      if params[:search_method].to_i==1 #完全一致
        @books=Book.where('title like ?',"#{params[:search_text]}")
      elsif params[:search_method].to_i==2#前方一致
        @books=Book.where('title like ?', "#{params[:search_text]}%")
      elsif params[:search_method].to_i==3#後方一致
        @books=Book.where('title like ?',"%#{params[:search_text]}")
      elsif params[:search_method].to_i==4#部分一致
        @books=Book.where('title like ?', "%#{params[:search_text]}%")
      end
      render :search_book
    end
  end
end
