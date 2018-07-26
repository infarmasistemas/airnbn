class RoomsController < ApplicationController
  before_action :require_authentication,
                :only => [:new, :edit, :create, :update, :destroy]

  def index
    # retorna quartos em order decrescente
    @rooms = Room.order(created_at: :desc)
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
        # https://stackoverflow.com/questions/30148802/why-completed-406-not-acceptable-has-gone-after-removing-respond-to?rq=1
        # redirect_to @room, :notice => t('flash.notice.room_updated')
        format.html { render => 'foi'  }
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