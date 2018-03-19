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
        function H = height(obj,x)
            p = [-25./16 15./8 0 0];
            H = zeros(size(x));
            
            for i = 1:numel(x)
                if x(i) < obj.bumpStart || x(i) > obj.bumpStart + obj.bumpLength
                    H(i) = 0;
                elseif x(i) < obj.bumpStart + 0.8
                    H(i) = polyval(p,x(i)-obj.bumpStart);
                elseif x(i) < obj.bumpStart + obj.bumpLength - 0.8
                    H(i) = obj.bumpHeight;
                else
                    H(i) = polyval(p,-x(i)+obj.bumpStart+obj.bumpLength);
                end
            end
        end
        function S = slope(obj,x)
            S = zeros(size(x));
            p = polyder([-25./16 15./8 0 0]);
            for i = 1:numel(x)
                if (x(i) > obj.bumpStart && x(i) < obj.bumpStart + 0.8)
                    S(i) = polyval(p,x(i)-obj.bumpStart);
                elseif (x(i) > obj.bumpStart + obj.bumpLength - 0.8 && x(i) < obj.bumpStart + obj.bumpLength)
                    S(i) = -polyval(p,-x(i)+obj.bumpStart+obj.bumpLength);
                else
                    S(i) = 0;
                end
            end
            S = atan(S);
        end
    end
end