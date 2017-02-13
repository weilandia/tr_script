class Clin
  attr_reader :all
  def initialize(all=[])
    @all = all
  end

  def create(data)
    @all << data
  end

  def generate_output!
    output = header

    all.each_with_index { |line, i|
      output << generate_line(line, i + 1)
    }

    output << footer

    File.write("./anacapatr_#{date}", output.join("\n"))
  end

  def generate_line(line, num)
    [
      "LIN [#{num}",
      "CLIN [#{line[:clin]}",
      "CLINTYPE [#{line[:clintype]}",
      "PROVIDER [#{line[:provider]}",
      "PARTNUMBER [#{line[:partnumber]}",
      "DISCOUNTCLASS [#{line[:discountclass]}",
      "DISCOUNTSUBCLASS [#{line[:discountsubclass]}",
      "MA [#{line[:ma]}",
      "LISTPRICE [#{line[:listprice]}",
      "SEWPPRICE [#{line[:sewpprice]}",
      "ITEMDESC [#{line[:itemdesc]}",
      "TAAFLAG [#{line[:taaflag]}"
    ]
  end

  def header
    [
      "REPORTTYPE [TR",
      "TRNUMBER [#{date}",
      "CONTRACTNO [NNG15SD64B",
      "TRDESC [SEWP 5 Additional CLINs #{date}",
      "CONTACTNAME [Glen Anderson",
      "CONTACTPHONE [800-800-7056 ",
      "CONTACTEMAIL [anderson@anacapamicro.com ",
      "FORWARDNOERROR [Y"
    ]
  end

  def footer
    [
      "TOTALCLINS [#{count}",
      "ENDREPORT ["
    ]
  end

  def date
    @date ||= Time.now.strftime("%Y%m%d")
  end

  def count
    all.count
  end
end
