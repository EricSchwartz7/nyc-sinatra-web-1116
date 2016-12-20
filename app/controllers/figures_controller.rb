class FiguresController < ApplicationController

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.create(name: params["figure"]["name"])
    if !params["title"]["name"].empty?
      @title = Title.create(name: params["title"]["name"])
      @figure.titles << @title
    else
      @figure.title_ids = params['figure']["title_ids"]
    end
    # @figure_titles = FigureTitle.create(title_id: @title.id, figure_id: @figure.id)
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
    else
      @figure.landmark_ids = params['figure']['landmark_ids']
    end

    # @landmark.figure_id = @figure.id
    # @landmark.save
    @figure.save
    redirect '/figures'
  end

  # Show

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  ## Edit

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])

    if !params["title"]["name"].empty?
      @title = Title.create(name: params["title"]["name"])
      @figure.titles << @title
    else
      @figure.title_ids = params['figure']["title_ids"]
    end
    # @figure_titles = FigureTitle.create(title_id: @title.id, figure_id: @figure.id)
    if !params["landmark"]["name"].empty?
      @landmark = Landmark.create(name: params["landmark"]["name"])
      @figure.landmarks << @landmark
    else
      @figure.landmark_ids = params['figure']['landmark_ids']
    end
    # @figure.save
    redirect "/figures/#{@figure.id}"
    # "#{@landmark.name}"
  end

end
