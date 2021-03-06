## Matrix inversion is usually a costly computation and there may be some benefit to 
## caching the inverse of a matrix rather than compute it repeatedly
## 

## Creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = numeric()) {
	#initialize the cache 
	m <- NULL	
				
	#set the value of the matrix
	set <- function(y) {
			x <<- y
			m <<- NULL			
	}
			
	#get the value of the matrix			
	get <- function() x
	
	#set the cached data for inverse of the matrix	
	setsolve <- function(s) m <<- s
	
	#get the cached data for inverse of the matrix			
	getsolve <- function() m	
	
	#list of available functions
	list(set = set, get = get,
		 setsolve = setsolve,
		 getsolve = getsolve)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then cacheSolve should retrieve the inverse from the cache.		
cacheSolve <- function(x, ...) {
	## call the getsolve function to see if the cache exists      
	m<-x$getsolve()			
	
	## if the cache is not null (it exists), return the cache		
	if(!is.null(m)) {
			message("getting cached data")
			return(m)
	}
	
	## else, calculate the inverse....
	data <- x$get()
	m <- solve(data)	
	
	## then put it in the cache
	x$setsolve(m)
	
	## then return the freshly calculated inverse
	m
}
