
function fraciter(input, base = input)
    #returns the matrix obtained by replacing every line in 'base' by 'input'
    #input and base are of the form [x1 y1; x2 y2;...]
    
    l = size(input, 1)
    m = size(base, 1)
    
    output = zeros(1 + (l-1)*(m-1),2)

    for n = 1:m - 1
 
        s = sqrt((base[n+1,1]-base[n,1])^2 + (base[n+1,2]-base[n,2])^2) #length of step
        theta = atan2((base[n+1,2]-base[n,2]),(base[n+1,1]-base[n,1])) #angle of step

        rot = [cos(theta) sin(theta); -sin(theta) cos(theta)] #rotation matrix (transposed)
        
        output[1+(l-1)*(n-1):1+(l-1)*n,:] = (s * input * rot) #rotate and scale
        output[1+(l-1)*(n-1):1+(l-1)*n,1] += base[n,1] #translate x
        output[1+(l-1)*(n-1):1+(l-1)*n,2] += base[n,2] #translate y
    end
    return output
end

function frac(start, iterations)
    #performs 'iterations' fractal iterations on 'start'

    output = [0 0;1 0] #intiialize
    
    for n=0:floor(Integer,log(2,iterations))
        
        k = 2^n
        if iterations & k == k #compare to binary representation
            output = fraciter(start, output)
        end
        
        start = fraciter(start) #move to next power of 2
        
    end
    return output
end
