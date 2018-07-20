class RoomsController < ApplicationController
  before_action :require_authentication,
                :only => [:new, :edit, :create, :update, :destroy]

  def index
    @rooms = Room.most_recent
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_created')
    else
      render action: "new"
    end
  end

  def update
    # busca apenas os quartos do usuário logado
    @room = current_user.rooms.find(params[:id])

    respond_to do |format|
        if @room.update_attributes(room_params)
          redirect_to @room, :notice => t('flash.notice.room_updated')
        else
          render :action => "edit"
        end
     end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    redirect_to rooms_url
  end

  def most_recent
    # retorna os quartos mais recentes baseados no id
    # equivalente ao sql
    # select * from room order by id desc
    @room = Room.order(:id).reverse_order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # http://guides.rubyonrails.org/v3.2.9/security.html
    def room_params
      params.require(:room).permit(:title, :location, :description, :user_id)
    end
end