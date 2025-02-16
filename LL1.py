#Array Implemetnation
print("Array implementation")

class Node:
    def __init__(self, value):
        self.value = value
        self.next = None

class LinkedList:
    def __init__(self, value):
        new_node = Node(value)
        self.head = new_node
        self.tail = new_node
        self.length = 1

    def printList(self):
        temp = self.head
        while temp is not None:
            print(temp.value)
            temp = temp.next
    
    def append(self, values):
        new_node = Node(values)
        if self.length ==0:
            self.head = new_node
            self.tail = new_node
        else:
            self.tail.next =new_node
            self.tail = new_node
        self.length+=1

    def pop(self):
        if self.length ==0:
            return None
        elif self.length ==1:
            self.head = None
            self.tail = None
            self.length -=1   
        else:    
            temp = self.head
            while(temp.next.next!=None):
                temp = temp.next
                
            self.tail = temp
            self.tail.next = None
            self.length -=1
    
    def prepend(self, value):
        new_node = Node(value)
        if self.length ==0:
            self.head = new_node
            self.tail = new_node
        else:    
            new_node.next  = self.head
            self.head = new_node
        self.length +=1
    
    def popFirst(self):
        if self.length ==0:
            return None
        temp = self.head
        self.head = self.head.next
        temp.next = None
        self.length-=1
        if self.length ==0:
            self.tail = None
        return temp
    
    def get(self, index):
        if index== 0:
            return self.head
        temp = self.head
        for i in range(index):
            temp = temp.next
        return temp
    
    def set_value(self, index, value):
        temp  = self.get(index)
        if temp : 
            temp.value = value
            return True
        return False
    
    def insert(self, index, value):
        new_node =Node(value)
        if index<0 or index > self.length:
            return False
        if index ==0:
            return self.prepend(value)
        if index == self.length :
            return self.append(value)
        temp  = self.get(index-1)
        new_node.next = temp.next
        
        temp.next=new_node
        self.length+=1
        return True
    
    def remove(self, index):
        if index < 0 or index >= self.length:
            return None
        if index == 0:
            return self.popFirst()
        if index == self.length-1:
            return self.pop()
        prev = self.get(index-1)
        temp = prev.next
        prev.next = temp.next
        temp.next = None
        self.length-=1
        return temp
        
    def reverse(self):
        temp = self.head
        self.head = self.tail
        self.tail = temp
        
        after = temp.next
        before = None

        for i in range(self.length):
            after = temp.next
            temp.next = before
            before = temp
            temp = after


        

    


    


myLL = LinkedList(2)
myLL.append(4)
myLL.printList()
print("`````````")
myLL.pop()
myLL.printList()
print("`````````")
myLL.pop()
myLL.printList()
#print(myLL.head.value)