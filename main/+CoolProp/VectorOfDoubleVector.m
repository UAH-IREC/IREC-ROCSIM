classdef VectorOfDoubleVector < SwigRef
  methods
    function varargout = pop(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(44, self, varargin{:});
    end
    function varargout = paren(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(45, self, varargin{:});
    end
    function varargout = paren_asgn(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(46, self, varargin{:});
    end
    function varargout = append(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(47, self, varargin{:});
    end
    function varargout = empty(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(48, self, varargin{:});
    end
    function varargout = size(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(49, self, varargin{:});
    end
    function varargout = clear(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(50, self, varargin{:});
    end
    function varargout = swap(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(51, self, varargin{:});
    end
    function varargout = get_allocator(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(52, self, varargin{:});
    end
    function varargout = begin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(53, self, varargin{:});
    end
    function varargout = end(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(54, self, varargin{:});
    end
    function varargout = rbegin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(55, self, varargin{:});
    end
    function varargout = rend(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(56, self, varargin{:});
    end
    function varargout = pop_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(57, self, varargin{:});
    end
    function varargout = erase(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(58, self, varargin{:});
    end
    function self = VectorOfDoubleVector(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(59, varargin{:});
        tmp = CoolPropMATLAB_wrap(59, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function varargout = push_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(60, self, varargin{:});
    end
    function varargout = front(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(61, self, varargin{:});
    end
    function varargout = back(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(62, self, varargin{:});
    end
    function varargout = assign(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(63, self, varargin{:});
    end
    function varargout = resize(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(64, self, varargin{:});
    end
    function varargout = insert(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(65, self, varargin{:});
    end
    function varargout = reserve(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(66, self, varargin{:});
    end
    function varargout = capacity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(67, self, varargin{:});
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(68, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
