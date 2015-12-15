require 'csv'
require './auto_seeker'

data = CSV.read('foobarnian_autos.csv')

seeker = AutoSeeker.new data
autos = seeker.filter(:color, ARGV[0])

if ARGV[1]
  unless ARGV[1] == 'all'
    autos = autos.find_all { |auto| auto.fuel == ARGV[1] }
  end
end

if ARGV[2]
  unless ARGV[2] == 'all'
    min_max = ARGV[2].split(',')
    min_max.map! { |value| value.to_f}
    autos = autos.find_all { |auto| auto.price.to_f >= min_max[0] && auto.price.to_f <= min_max[1]}
  end
end

if autos.length == 0
  abort "filter returned no results"
end

mileage = AutoSeeker.median_mileage(autos)

puts "median mileage = #{mileage} MPG"
