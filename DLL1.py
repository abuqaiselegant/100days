class Node:
    def __init__(self, value):
        self.value = value
        self.next = None
        self.prev = None
    
class DoublyLinkedList:
    def __init__(self,value):
        new_Node = Node(value)
        self.head = new_Node
        self.tail = new_Node
        self.length =1
    
    def print_list(self):
        temp = self.head
        while temp is not None:
            print(temp.value)
            temp = temp.next

    def append(self, value):
        new_node = Node(value)
        if self.head is None:
            self.head = new_node
            self.tail = new_node
        else:
            self.tail.next = new_node
            new_node.prev = self.tail
            self.tail = new_node
        self.length+=1
        return True
    
    #rearranged and easier to read
    def pop(self):
        if self.length ==0:
            return None
        temp = self.tail
        if self.length ==1:
            self.head = None
            self.tail = None
        else:
            self.tail = self.tail.prev
            self.tail.next = None
            temp.prev = None
        self.length-=1    
        return 
    
    def prepend(self, value):
        node = Node(value)
        if self.length ==0:
            self.head = node
            self.tail = node
        else:
            node.next = self.head
            self.head.prev = node
            self.head = node
        self.length+=1
        return True
    
    def popfirst(self):
        if self.length ==0:
            return None
        temp = self.head
        if self.length ==1:
            self.head = None
            self.tail = None
        else:
            self.head = self.head.next
            self.head.prev = None
            temp.next = None
        self.length-=1
        return temp
    
    def get(self, index):
        if index<0 or index>=self.length:
            return None
        temp = self.head
        if index<self.length/2:
            for i in range(index):
                temp = temp.next
        else:
            temp = self.tail
            for i in range(self.length-1, index, -1):
                temp = temp.prev
        return temp
    
    def set(self, index, value):
        temp = self.get(index)
        if temp:
            temp.value = value
            return True
        return False
    
    def insert(self, index, value):
        if index <0 or index>self.length:
            return False
        if index == 0:
            return self.prepend(value)
        if  index == self.length:
            return self.append(value)
    
        node = Node(value)
        '''temp = self.get(index-1)
        node.next = temp.next
        node.prev = temp
        temp.next.prev = node
        temp.next = node'''

        before = self.get(index-1)
        after = before.next

        node.next = after
        node.prev = before
        before.next = node
        after.prev = node

        self.length+=1
        return True
    
    def Remove(self, index):
        if index<0 or index>= self.length:
            return None
        if index == 0:
            return self.popfirst()
        if index== self.length-1:
            return self.pop()
        
        temp = self.get(index)
        '''before = temp.prev
        after = temp.next

        before.next = after
        after.prev = before
        temp.next = None
        temp.prev = None'''
        temp.prev.next = temp.next
        temp.next.prev = temp.prev
        temp.next = None
        temp.prev = None
        self.length-=1
        return temp
    
    




        




my_doubly_LL = DoublyLinkedList(8)
my_doubly_LL.print_list()
