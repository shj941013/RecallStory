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

    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: 'Memory was successfully updated.' }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @memory.destroy
    respond_to do |format|
      format.html { redirect_to memories_url, notice: 'Memory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    def correct_user
      @memory = current_user.memories.find_by(id: params[:id])
      redirect_to memories.path, notice: "Not authorized to edit this memory" if memory.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memory_params
      params.require(:memory).permit(:description)
    end
end
