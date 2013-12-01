module TransformableTableViewCell
  def self.included(other)
    other.instance_eval do
      attr_accessor :finishedHeight
    end
  end
end

