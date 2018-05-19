class YoutubeController < ActionController::Base
  private

  DEVELOPER_KEY = 'AIzaSyCcdt8VWix3eDh9V1cI3gLNboZiBBg1UDQ'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def get_service
    client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
    return client, youtube
  end

  public
  def index
  end

  def search_movie
    @search_word = params[:search_word]

    opts = Trollop::options do
      opt :q, @search_word, :type => String, :default => 'Google'
      opt :max_results, 'Max results', :type => :int, :default => 25
    end

    client, youtube = get_service


    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => @search_word,
          :maxResults => opts[:max_results]
          }
        )


      @videos = []
      @channels = []

      # Add each result to the appropriate list, and then display the lists of
      # matching videos, channels, and playlists.
      search_response.data.items.each do |search_result|
        case search_result.id.kind
        when 'youtube#video'
          @videos << search_result
        when 'youtube#channel'
          @channels << search_result
        end
      end
    rescue Google::APIClient::TransmissionError => e
      flash.now[:error] = e.result.body
      render action: :index
      return false
    end
  end

end
