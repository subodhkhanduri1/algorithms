# Recursive Merge-sort implementation
#
# Time Complexity => O(nlogn)
# Space Complexity => O(n)
#
class MergeSorter

  def initialize(original_array)
    self.original_array = original_array
  end

  def sort
    sort_between(0, original_array.size - 1)
  end

  private

  attr_accessor :original_array

  def sort_between(start_index, end_index)
    return [original_array[start_index]] if start_index == end_index
    return sorted_2_item_array(start_index, end_index) if end_index - start_index == 1

    mid_index = (start_index + end_index) / 2
    left_sorted_array = sort_between(start_index, mid_index)
    right_sorted_array = sort_between(mid_index + 1, end_index)

    merge(left_sorted_array, right_sorted_array)
  end

  def merge(first_array, second_array)
    first_array_index = 0
    second_array_index = 0

    merged_array = []
    while first_array_index < first_array.size && second_array_index < second_array.size
      if first_array[first_array_index] < second_array[second_array_index]
        merged_array << first_array[first_array_index]
        first_array_index += 1
      else
        merged_array << second_array[second_array_index]
        second_array_index += 1
      end
    end

    insert_remaining_array_elements(merged_array, first_array, first_array_index)
    insert_remaining_array_elements(merged_array, second_array, second_array_index)

    merged_array
  end

  def sorted_2_item_array(start_index, end_index)
    if original_array[start_index] > original_array[end_index]
      [original_array[end_index], original_array[start_index]]
    else
      [original_array[start_index], original_array[end_index]]
    end
  end

  def insert_remaining_array_elements(merged_array, array, index)
    while index < array.size
      merged_array << array[index]
      index += 1
    end
  end
end

MergeSorter.new((1..100).to_a.reverse).sort
