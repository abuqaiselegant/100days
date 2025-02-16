class Maxheap:
    def __init__(self):
        self.heap = []
    def _left_child(self, index):
        return 2* index + 1
    def _right_child(self, index):
        return 2*index +2
    def _parent(self, index):
        return (index-1)//2
    def _swap(self, index1, index2):
        self.heap[index1], self.heap[index2] = self.heap[index2], self.heap[index1]



    def insert(self,value):
        self.heap.append(value)
        current = len(self.heap)-1

        while current>0 and self.heap[current]>self.heap[self._parent(current)]:
            self._swap(current, self._parent(current))
            current = self._parent(current)


    #def _sinkdown(self):

#only top element will remove
    def remove(self, value):
        if len(self.heap)==0:
            return None
        if len(self.heap)== 1:
            return self.heap.pop()
        max_value = self.heap[0]
        self.heap[0] = self.heap.pop()
        self._sink_down()

        return max_value
    



myHeap = Maxheap()
myHeap.insert(99)
#myHeap.insert(98)
myHeap.insert(72)
myHeap.insert(61)
myHeap.insert(58)

print(myHeap.heap)

myHeap.insert(100)
print(myHeap.heap)

myHeap.insert(75)
print(myHeap.heap)