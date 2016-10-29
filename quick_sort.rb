# In-place Quick sort implemetation
#
# Time Complexity => worst case: O(n^2), average: O(nlogn)
# Space Complexity => None
#
class QuickSorter

  def initialize(original_array)
    self.original_array = original_array
  end

  def sort!
    sort_between(0, original_array.size - 1)
  end

  private

  attr_accessor :original_array

  def sort_between(start_index, end_index)
    return if end_index < start_index

    pivot_index = create_partition(start_index, end_index)

    sort_between(start_index, pivot_index - 1)
    sort_between(pivot_index + 1, end_index)
  end

  def create_partition(start_index, end_index)
    pivot_index = start_index # + rand(end_index - start_index + 1)
    search_for_greater = false
    index = end_index

    while true
      index = if search_for_greater
                search_and_swap_with_greater_element(index, pivot_index)
              else
                search_and_swap_with_smaller_element(index, pivot_index)
              end

      break if index == pivot_index

      search_for_greater = !search_for_greater
    end

    pivot_index
  end

  def search_and_swap_with_greater_element(index, pivot_index)
    while index < pivot_index
      if original_array[index] >= original_array[pivot_index]
        break
      end
      index += 1
    end

    return index if index == pivot_index

    swap_in_array(index, pivot_index)

    t = pivot_index
    pivot_index = index
    index = t

    index
  end

  def search_and_swap_with_smaller_element(index, pivot_index)
    while index > pivot_index
      if original_array[index] < original_array[pivot_index]
        break
      end
      index -= 1
    end

    return index if index == pivot_index

    swap_in_array(index, pivot_index)

    t = pivot_index
    pivot_index = index
    index = t

    index
  end

  def swap_in_array(first_index, second_index)
    temp = original_array[first_index]
    original_array[first_index] = original_array[second_index]
    original_array[second_index] = temp
  end

end

array = (1..10).to_a.reverse
q = QuickSorter.new(array)
q.sort!
array
