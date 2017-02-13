require 'csv'
require 'pry'
require_relative './clin'

class TrBatch
  def self.from_csv(data)
    clin = Clin.new
    CSV.open(data, headers: true, header_converters: :symbol).each do |row|
      clin.create(row.to_hash)
    end
    clin.generate_output!
  end
end

TrBatch.from_csv(ARGV[0])
