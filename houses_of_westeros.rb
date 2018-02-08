require 'sinatra'
require 'yaml/store'

get '/' do
  @title = "Welcome to 'Houses of Westeros'"
  erb :index
end

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results so far:'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

Choices = {
  'ARR' => 'Arryn of the Eyrie',
  'BAR' => 'Baratheon of Storm\'s End',
  'GRY' => 'Greyjoy of Pyke',
  'LAN' => 'Lanister of Casterly Rock',
  'MAR' => 'Martell of Sunspear',
  'STK' => 'Stark of Winterfell',
  'TAR' => 'Targaryen of King\'s Landing',
  'TUL' => 'Tully of Riverrun',
  'TYR' => 'Tyrell of Highgarden',
  'ESO' => 'Westeros? I much prefer the folks in Essos.',
  'WLD' => 'Free Folk for Life. I\'m a Wildling.',
}
