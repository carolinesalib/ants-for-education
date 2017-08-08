class IeducarConfigurationsController < ApplicationController
  def edit
    @configuration = IeducarConfiguration.find(params[:id])
  end

  def update
    if @configuration.update(params_configuration)
      redirect_to backoffice_categories_path,
                  notice: "Atualizado com sucesso"
    else
      render :edit
    end
  end

  private

  def params_configuration
    params.require(:ieducar_configuration).permit(:url)
  end
end
