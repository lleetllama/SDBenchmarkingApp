class SdModelsController < ApplicationController
  before_action :set_sd_model, only: %i[ show edit update destroy ]

  # GET /sd_models or /sd_models.json
  def index
    @sd_models = SdModel.all
  end

  # GET /sd_models/1 or /sd_models/1.json
  def show
  end

  # GET /sd_models/new
  def new
    @sd_model = SdModel.new
  end

  # GET /sd_models/1/edit
  def edit
  end

  # POST /sd_models or /sd_models.json
  def create
    @sd_model = SdModel.new(sd_model_params)

    respond_to do |format|
      if @sd_model.save
        format.html { redirect_to sd_model_url(@sd_model), notice: "Sd model was successfully created." }
        format.json { render :show, status: :created, location: @sd_model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sd_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sd_models/1 or /sd_models/1.json
  def update
    respond_to do |format|
      if @sd_model.update(sd_model_params)
        format.html { redirect_to sd_model_url(@sd_model), notice: "Sd model was successfully updated." }
        format.json { render :show, status: :ok, location: @sd_model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sd_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sd_models/1 or /sd_models/1.json
  def destroy
    @sd_model.destroy!

    respond_to do |format|
      format.html { redirect_to sd_models_url, notice: "Sd model was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sd_model
      @sd_model = SdModel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sd_model_params
      params.require(:sd_model).permit(:name, :description, :ckpt_path, :civitai_link, :sample_image_url)
    end
end
