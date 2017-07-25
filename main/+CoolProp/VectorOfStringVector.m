classdef VectorOfStringVector < SwigRef
  methods
    function varargout = pop(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(94, self, varargin{:});
    end
    function varargout = paren(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(95, self, varargin{:});
    end
    function varargout = paren_asgn(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(96, self, varargin{:});
    end
    function varargout = append(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(97, self, varargin{:});
    end
    function varargout = empty(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(98, self, varargin{:});
    end
    function varargout = size(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(99, self, varargin{:});
    end
    function varargout = clear(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(100, self, varargin{:});
    end
    function varargout = swap(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(101, self, varargin{:});
    end
    function varargout = get_allocator(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(102, self, varargin{:});
    end
    function varargout = begin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(103, self, varargin{:});
    end
    function varargout = end(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(104, self, varargin{:});
    end
    function varargout = rbegin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(105, self, varargin{:});
    end
    function varargout = rend(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(106, self, varargin{:});
    end
    function varargout = pop_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(107, self, varargin{:});
    end
    function varargout = erase(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(108, self, varargin{:});
    end
    function self = VectorOfStringVector(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(109, varargin{:});
        tmp = CoolPropMATLAB_wrap(109, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function varargout = push_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(110, self, varargin{:});
    end
    function varargout = front(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(111, self, varargin{:});
    end
    function varargout = back(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(112, self, varargin{:});
    end
    function varargout = assign(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(113, self, varargin{:});
    end
    function varargout = resize(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(114, self, varargin{:});
    end
    function varargout = insert(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(115, self, varargin{:});
    end
    function varargout = reserve(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(116, self, varargin{:});
    end
    function varargout = capacity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(117, self, varargin{:});
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(118, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
