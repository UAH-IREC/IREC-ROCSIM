classdef StringVector < SwigRef
  methods
    function varargout = pop(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(69, self, varargin{:});
    end
    function varargout = paren(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(70, self, varargin{:});
    end
    function varargout = paren_asgn(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(71, self, varargin{:});
    end
    function varargout = append(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(72, self, varargin{:});
    end
    function varargout = empty(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(73, self, varargin{:});
    end
    function varargout = size(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(74, self, varargin{:});
    end
    function varargout = clear(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(75, self, varargin{:});
    end
    function varargout = swap(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(76, self, varargin{:});
    end
    function varargout = get_allocator(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(77, self, varargin{:});
    end
    function varargout = begin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(78, self, varargin{:});
    end
    function varargout = end(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(79, self, varargin{:});
    end
    function varargout = rbegin(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(80, self, varargin{:});
    end
    function varargout = rend(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(81, self, varargin{:});
    end
    function varargout = pop_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(82, self, varargin{:});
    end
    function varargout = erase(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(83, self, varargin{:});
    end
    function self = StringVector(varargin)
      if nargin~=1 || ~ischar(varargin{1}) || ~strcmp(varargin{1},'_swigCreate')
        % How to get working on C side? Commented out, replaed by hack below
        %self.swigInd = CoolPropMATLAB_wrap(84, varargin{:});
        tmp = CoolPropMATLAB_wrap(84, varargin{:}); % FIXME
        self.swigInd = tmp.swigInd;
        tmp.swigInd = uint64(0);
      end
    end
    function varargout = push_back(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(85, self, varargin{:});
    end
    function varargout = front(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(86, self, varargin{:});
    end
    function varargout = back(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(87, self, varargin{:});
    end
    function varargout = assign(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(88, self, varargin{:});
    end
    function varargout = resize(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(89, self, varargin{:});
    end
    function varargout = insert(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(90, self, varargin{:});
    end
    function varargout = reserve(self,varargin)
      [varargout{1:nargout}] = CoolPropMATLAB_wrap(91, self, varargin{:});
    end
    function varargout = capacity(self,varargin)
      [varargout{1:max(1,nargout)}] = CoolPropMATLAB_wrap(92, self, varargin{:});
    end
    function delete(self)
      if self.swigInd
        CoolPropMATLAB_wrap(93, self);
        self.swigInd=uint64(0);
      end
    end
  end
  methods(Static)
  end
end
