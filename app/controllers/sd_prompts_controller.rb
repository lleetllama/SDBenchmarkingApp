class SdPromptsController < ApplicationController
  before_action :set_sd_prompt, only: %i[ show edit update destroy ]

  # GET /sd_prompts or /sd_prompts.json
  def index
    @sd_prompts = SdPrompt.all
  end

  # GET /sd_prompts/1 or /sd_prompts/1.json
  def show
  end

  # GET /sd_prompts/new
  def new
    @sd_prompt = SdPrompt.new
  end

  # GET /sd_prompts/1/edit
  def edit
  end

  # POST /sd_prompts or /sd_prompts.json
  def create
    @sd_prompt = SdPrompt.new(sd_prompt_params)

    respond_to do |format|
      if @sd_prompt.save
        format.html { redirect_to sd_prompt_url(@sd_prompt), notice: "Sd prompt was successfully created." }
        format.json { render :show, status: :created, location: @sd_prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sd_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sd_prompts/1 or /sd_prompts/1.json
  def update
    respond_to do |format|
      if @sd_prompt.update(sd_prompt_params)
        format.html { redirect_to sd_prompt_url(@sd_prompt), notice: "Sd prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @sd_prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sd_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sd_prompts/1 or /sd_prompts/1.json
  def destroy
    @sd_prompt.destroy!

    respond_to do |format|
      format.html { redirect_to sd_prompts_url, notice: "Sd prompt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sd_prompt
      @sd_prompt = SdPrompt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sd_prompt_params
      params.require(:sd_prompt).permit(:pos, :neg, :width, :height, :seed, :cfg, :name, :sample_image_url)
    end
end
