# In-place Heap sort
#
# Time complexity => O(nlogn)
# Space complexity => none
#
def heapsort(array)
  index = array.size - 1

  while index >= 0 do
    heapify(array, index, array.size)
    index -= 1
  end

  index = array.size - 1

  while index >= 0 do
    swap(array, index, 0)
    heapify(array, 0, index)
    index -= 1
  end

  array
end

def heapify(array, index, heap_size)
  left_child_index = (index * 2) + 1
  right_child_index = (index * 2) + 2
  max_index = index

  if left_child_index < heap_size && array[max_index] < array[left_child_index]
    max_index = left_child_index
  end

  if right_child_index < heap_size && array[max_index] < array[right_child_index]
    max_index = right_child_index
  end

  if max_index != index
    swap(array, index, max_index)
    heapify(array, max_index, heap_size)
  end
end

def swap(array, index1, index2)
  t = array[index1]
  array[index1] = array[index2]
  array[index2] = t
end

heapsort((1..10).to_a.reverse)
