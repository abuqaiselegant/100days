def twoSum(nums, target):
    i=0
    j = len(nums)-1
    while(i<j):
        if nums[i]+nums[j]==target:
            return True
        elif nums[i]+nums[j]<target:
            i+=1
        else:
            j-=1
    return False

a= [1,3,4,6,8,10,13]
b=13
print(twoSum(a, b))



def maxWater(arr):
    i =0
    j= len(arr)-1
    maxArea =0
    while i<j:
        area = min(arr[i],arr[j])*(j-i)
        maxArea = max(area, maxArea)
        if arr[i]<arr[j]:
            i+=1
        else:
            j-=1
    return maxArea


h = [3,4,1,2,2,4,1,3,2]
print(maxWater(h))


#VALID TRIANGLE NUMBER
def triangleNumber(nums):
    nums.sort()
    count = 0
    for k in range(len(nums)-1,1,-1):
        left, right = 0, k-1
        while left < right:
            if nums[left] + nums[right] > nums[k]:
                count+= right-left
                right-=1
            else:
                left+=1
    return count


a=[2,2,3,4]
ans = triangleNumber(a)
print(ans)

#fruit basket
def totalFruit(fruits):
    basket = {}
    left = 0
    max_fruits =0
    for right in range(len(fruits)):
        basket[fruits[right]] = basket.get(fruits[right],0)+1

        while len(basket) >2:
            basket[fruits[left]] -=1
            if basket[fruits[left]]==0:
                del basket[fruits[left]]
            left+=1
        max_fruits = max(max_fruits, right-left+1)
    return max_fruits

print(totalFruit([1, 2, 1, 2, 3, 2]))

#PrefixSum
