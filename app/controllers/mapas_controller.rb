class MapasController < ApplicationController
  before_action :set_mapa, only: [:show, :buscar, :edit, :update, :destroy]

  # GET /mapas
  # GET /mapas.json
  def index
    @mapas = Mapa.all
  end

  # GET /mapas/1
  # GET /mapas/1.json
  def buscar
    @rotas = {}
    @pontos= []
    @mapa.rotas.each do |r|
      add_rota(r.origem, r.destino, r.distancia)
      add_rota(r.destino, r.origem, r.distancia)
    end

    @resposta = dijkstra(params[:origem], params[:destino])
    if @resposta
      @resposta[:custo] =  @resposta[:distancia].to_f / params[:autonomia].to_f * params[:combustivel].to_f
      @resposta[:custo] = 0 if @resposta[:custo].nan? || @resposta[:custo] == Float::INFINITY
    else
      @resposta = {distancia: 0, caminho: 'Não encontrado', custo: 0}
    end

    respond_to do |format|
      format.js
    end
  end

  # GET /mapas/new
  def new
    @mapa = Mapa.new
  end

  # GET /mapas/1/edit
  def edit
  end

  # POST /mapas
  # POST /mapas.json
  def create
    @mapa = Mapa.new(mapa_params)

    respond_to do |format|
      if @mapa.save
        format.html { redirect_to @mapa, notice: 'Mapa foi criado com sucesso.' }
        format.json { render :show, status: :created, location: @mapa }
      else
        format.html { render :new }
        format.json { render json: @mapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mapas/1
  # PATCH/PUT /mapas/1.json
  def update
    respond_to do |format|
      if @mapa.update(mapa_params)
        format.html { redirect_to @mapa, notice: 'Mapa foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @mapa }
      else
        format.html { render :edit }
        format.json { render json: @mapa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mapas/1
  # DELETE /mapas/1.json
  def destroy
    @mapa.destroy
    respond_to do |format|
      format.html { redirect_to mapas_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mapa
    @mapa = Mapa.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mapa_params
    params.require(:mapa).permit(:nome, rotas_attributes: [:id, :mapa_id, :origem, :destino, :distancia, :_destroy])
  end

  def add_rota(origem, destino, distancia)
    if @rotas.has_key?(origem)
      @rotas[origem][destino] = distancia
    else
      @rotas[origem] = {destino => distancia}
    end
    @pontos << origem unless @pontos.include?(origem)
  end

  def dijkstra(origem, destino)
    distancias = {}
    anteriores = {}

    @pontos.each do |i|
      distancias[i] = nil
      anteriores[i] = nil
    end

    distancias[origem] = 0
    pontos = @pontos

    until pontos.empty?
      menor_rota = nil;
      menor_rota = pontos.inject do |a, b|
        next b unless distancias[a]
        next a unless distancias[b]
        next a if distancias[a] < distancias[b]
        b
      end
      break if distancias[menor_rota].nil?

      if menor_rota == destino
        return { caminho: obter_caminho(anteriores, origem, destino).reverse, distancia: distancias[destino] }
      end

      pontos = pontos - [menor_rota]

      @rotas[menor_rota].keys.each do |ponto|
        distancia = distancias[menor_rota] + @rotas[menor_rota][ponto]
        if distancias[ponto].nil? or distancia < distancias[ponto]
          distancias[ponto] = distancia
          anteriores[ponto] = menor_rota
        end
      end
    end
  end

  def obter_caminho(anteriores, origem, destino)
    return origem if origem == destino
    [destino, obter_caminho(anteriores, origem, anteriores[destino])].flatten
  end

end
