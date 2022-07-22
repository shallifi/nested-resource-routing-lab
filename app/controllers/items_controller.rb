class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = find_user
      items = user.items 
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    items = Item.find_by!(id: params[:id])
    render json: items, include: :user
  end

  def create
    user = find_user
    items = user.items.create(item_params)
    render json: items, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end


  def find_user
    User.find(params[:user_id])
  end

end
