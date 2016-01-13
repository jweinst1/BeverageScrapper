#object for storing informating about specific subjects
require 'set'
class SubjectList
  def initialize(words=[])
    @list = words
    @set = Set.new
    @dict = {}
    for elem in @list
      @dict[elem] = []
      @set << elem
    end
  end
  def list
    @list
  end
  def dict
    @dict
  end
  def set
    @set
  end
  def length
    @list.size
  end
  def contains(elem)
    @set.include?(elem)
  end
  def add(elem)
    @list << elem
    @set << elem
    @dict[:elem] = []
  end
end