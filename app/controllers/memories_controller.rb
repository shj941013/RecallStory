class MemoriesController < ApplicationController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @memories = Memory.all
  end

  def show
  end

  def new
    @memory = current_user.memories.build
  end

  def edit
  end

  def create
    @memory = current_user.memories.build(memory_params)

      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
      else
        format.html { render :new }
      end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
  def update
 
      if @memory.update(memory_params)
        redirect_to @memory, notice: 'Memory was successfully updated.'
      else
        render :edit 
      end
  end

  def destroy
    @memory.destroy

      redirect_to memories_url, notice: 'Memory was successfully destroyed.' 
      head :no_content 
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    def correct_user
      @memory = current_user.memories.find_by(id: params[:id])
      redirect_to memories_path, notice: "Not authorized to edit this pin" if @memory.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memory_params
      params.require(:memory).permit(:description, :image)
    end
end
