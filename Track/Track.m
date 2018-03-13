classdef Track
    properties
        bumpStart
        bumpLength
        bumpHeight
    end
    methods
        function obj = Track(bumpStart,bumpLength,bumpHeight)
            obj.bumpStart=bumpStart;
            obj.bumpLength=bumpLength;
            obj.bumpHeight=bumpHeight;
        end
        function h = height(obj,x)
            p = [-25./16 15./8 0 0];
            if x < obj.bumpStart || x > obj.bumpStart + obj.bumpLength
                h = 0;
            elseif x < obj.bumpStart + 0.8
                h = polyval(p,x-obj.bumpStart);
            elseif x < obj.bumpStart + obj.bumpLength - 0.8
                h = obj.bumpHeight;
            else
                h = polyval(p,-x+obj.bumpStart+obj.bumpLength);
            end
        end
        function s = slope(obj,x)
            p = polyder([-25./16 15./8 0 0]);
            if (x > obj.bumpStart && x < obj.bumpStart + 0.8)
                s = polyval(p,x-obj.bumpStart);
            elseif (x > obj.bumpStart + obj.bumpLength - 0.8 && x < obj.bumpStart + obj.bumpLength)
                s = polyval(p,-x+obj.bumpStart+obj.bumpLength);
            else
                s = 0;
            end
            
            s = radtodeg(atan(s));
        end
    end
end