# lec2_3.r : loop, for, while

# create a simple function

# square function

square<-function(x){
   return(x*x)
}
square(9)
square(1:3)

# difference between x and y

dif<-function(x,y){
  return(x-y)
}
dif(20,10)

# square root of dif(x,y)

rootdif<-function(x,y){
  return(sqrt(x-y))
}
rootdif(20,10)


# round off the decimal point
round(5.14846)
round(5.14846, 2)

# example
round(rootdif(20,10))
round(rootdif(20,10),2)

# for loop example1
# for 1 to 10
# if remainder=1 when deviding by 3
# then go to next number 

for(i in 1:10){
  if(i%%3 == 1){
    next()
  }
  print(i)
}

# for loop example2
# stop loop after sum>20
sum = 0
for (i in 1:10) {
  sum <- sum + i
  if (sum>20){
    # stop loop after sum>20
    break
  }
  print(sum)
}

# while loop
# while (condition) {expression}
y=0
while(y <5){ print(y<-y+1) }




