class SdModelPromptsController < ApplicationController
  before_action :set_sd_model_prompt, only: %i[ show edit update destroy ]

  # GET /sd_model_prompts or /sd_model_prompts.json
  def index
    @sd_model_prompts = SdModelPrompt.order(sd_prompt_id: :desc).all
  end

  # GET /sd_model_prompts/1 or /sd_model_prompts/1.json
  def show

  end

  def regen
    @sd_model_prompt = SdModelPrompt.find(params[:id])
    @sd_model_prompt.img_url = nil
    @sd_model_prompt.sd_uuid = nil
    @sd_model_prompt.save
    @sd_model_prompt.generate_image
  end

  # GET /sd_model_prompts/new
  def new
    @sd_model_prompt = SdModelPrompt.new
    @sd_models = SdModel.all
    @sd_prompts = SdPrompt.all
  end

  # GET /sd_model_prompts/1/edit
  def edit
    @sd_models = SdModel.all
    @sd_prompts = SdPrompt.all
  end

  # POST /sd_model_prompts or /sd_model_prompts.json
  def create
    @sd_model_prompt = SdModelPrompt.new(sd_model_prompt_params)

    respond_to do |format|
      if @sd_model_prompt.save
        format.html { redirect_to sd_model_prompt_url(@sd_model_prompt), notice: "Sd model prompt was successfully created." }
        format.json { render :show, status: :created, location: @sd_model_prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sd_model_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sd_model_prompts/1 or /sd_model_prompts/1.json
  def update
    respond_to do |format|
      if @sd_model_prompt.update(sd_model_prompt_params)
        format.html { redirect_to sd_model_prompt_url(@sd_model_prompt), notice: "Sd model prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @sd_model_prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sd_model_prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sd_model_prompts/1 or /sd_model_prompts/1.json
  def destroy
    @sd_model_prompt.destroy!

    respond_to do |format|
      format.html { redirect_to sd_model_prompts_url, notice: "Sd model prompt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sd_model_prompt
      @sd_model_prompt = SdModelPrompt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sd_model_prompt_params
      params.require(:sd_model_prompt).permit(:sd_model_id, :sd_prompt_id, :sd_uuid, :img_url)
    end
end
