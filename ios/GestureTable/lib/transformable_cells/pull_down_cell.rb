class PullDownTableViewCell < UITableViewCell
  include TransformableTableViewCell

  def initialize(reuse_id, target_height)
    self.initWithStyle(UITableViewCellStyleDefault,
                       reuseIdentifier: reuse_id)

    transform = CATransform3DIdentity
    transform.m34 = -1 / 500.0
    contentView.layer.setSublayerTransform(transform)

    self.selectionStyle = UITableViewCellSelectionStyleNone
    self.tintColor = UIColor.whiteColor

    @label_rotator = TextLabelRotator.new(textLabel, target_height)
  end

  def layoutSubviews
    super
    @label_rotator.height = self.frame.size.height
  end
end
