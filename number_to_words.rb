module NumberToWords

  def to_words(number = self)

    number_array = number.to_s.chars.map(&:to_i)

    #collection of method names
    methods = [:get_low_number, :get_tens_number, :get_hundreds_number, :get_thousands_number, :get_tens_thousands_number, :get_hundred_thousands_number]

    #use the methods depending on the index (size) of the number.
    full_number = []
    number_array.reverse.each_with_index do |value, index|
      number_value = self.send(methods[index],(value))
      full_number << number_value
    end

    #form the full string by adding the different parts together
    returned_string = ""
    full_number.reverse.each {|word| returned_string << word}
    returned_string = fix_edge_cases(returned_string)

    return returned_string
  end

  def fix_teens(edge_array)
      index = edge_array.index("CHANGE")
      case edge_array[index+1]
        when "one"
          edge_array[index+1] = "eleven"
        when "two"
          edge_array[index+1] = "twelve"
        when "three"
          edge_array[index+1] ="thirteen"
        when "four"
          edge_array[index+1] = "fourteen"
        when "five"
          edge_array[index+1] = "fifteen"
        when "six"
          edge_array[index+1] = "sixteen"
        when "seven"
          edge_array[index+1] = "seventeen"
        when "eight"
          edge_array[index+1] = "eighteen"
        when "nine"
          edge_array[index+1] = "nineteen"
        end
        edge_array.delete_at(index)
  end

  def log_delete(edge_array)
    to_delete = []
    # log where there are "ands" next to each other
    edge_array.each_with_index do |value, index|
      if value == "and" && edge_array[index+1] == "and"
        to_delete << index unless to_delete.include? (index)
        to_delete << index + 1 #unless to_delete.include? (index + 1)
      end
    end
    to_delete
  end

  def remove_extra_ands(edge_array, to_delete)
    # check if there are ands to delete
    unless to_delete.nil?
      log = -1
      to_delete.each_with_index do |index_to_delete, delete_value|
        log +=1
        edge_array.delete_at(index_to_delete- log) unless delete_value == to_delete.length-1
      end
    end
  end

  def remove_trailing_ands(edge_array, to_delete)
    #delete ands off the end if it is the last word
    while edge_array[edge_array.length-1] == "and"
      edge_array.delete_at(edge_array.length-1)
    end
  end

  def fix_edge_cases(number_string)
    rstring = number_string
    edge_array = number_string.split(" ")

    fix_teens(edge_array) if edge_array.include? "CHANGE"
    to_delete = log_delete(edge_array)
    remove_extra_ands(edge_array, to_delete)
    remove_trailing_ands(edge_array, to_delete)
    rstring = edge_array.join(" ")
    return rstring
  end

  def get_low_number(number)

    case number
      when 0
        ""
      when 1
        "one"
      when 2
        "two"
      when 3
        "three"
      when 4
        "four"
      when 5
        "five"
      when 6
        "six"
      when 7
        "seven"
      when 8
        "eight"
      when 9
        "nine"
    end
  end

  def get_tens_number(tens)

    case tens
      when 0
      "and "
      when 1
        "CHANGE "
      when 2
        "twenty "
      when 3
        "thirty "
      when 4
        "forty "
      when 5
        "fifty "
      when 6
        "sixty "
      when 7
        "seventy "
      when 8
        "eighty "
      when 9
        "ninety "
      end
  end

  def get_hundreds_number(hundreds)

    case hundreds
      when 0
          "and "
      when 1
        "one hundred "
      when 2
        "two hundred "
      when 3
        "three hundred "
      when 4
        "four hundred "
      when 5
        "five hundred "
      when 6
        "six hundred "
      when 7
        "seven hundred "
      when 8
        "eight hundred "
      when 9
        "nine hundred "
    end

  end

  def get_thousands_number(thousands)
    case thousands
      when 0
        "thousand and "
      when 1
        "one thousand "
      when 2
        "two thousand "
      when 3
        "three thousand "
      when 4
        "four thousand "
      when 5
        "five thousand "
      when 6
        "six thousand "
      when 7
        "seven thousand "
      when 8
        "eight thousand "
      when 9
        "nine thousand "
      end
  end

  def get_tens_thousands_number(tens_thousands)

    case tens_thousands
      when 0
      "and "
      when 1
        "CHANGE "
      when 2
        "twenty "
      when 3
        "thirty "
      when 4
        "forty "
      when 5
        "fifty "
      when 6
        "sixty "
      when 7
        "seventy "
      when 8
        "eighty "
      when 9
        "ninety "
    end
  end

  def get_hundred_thousands_number(hundred_thousands)

    case hundred_thousands
      when 1
        "one hundred and "
      when 2
        "two hundred and "
      when 3
        "three hundred and "
      when 4
        "four hundred and "
      when 5
        "five hundred and "
      when 6
        "six hundred and "
      when 7
        "seven hundred and "
      when 8
        "eight hundred and "
      when 9
        "nine hundred and "
      end
    end
  end

class Fixnum
  include NumberToWords
end