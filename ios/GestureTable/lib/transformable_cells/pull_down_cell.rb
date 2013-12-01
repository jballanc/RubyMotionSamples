class PullDownTableViewCell < UITableViewCell
  include TransformableTableViewCell

  def initialize(reuseIdentifier)
    if self.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: reuseIdentifier)
      transform = CATransform3DIdentity
      transform.m34 = -1 / 500.to_f
      contentView.layer.setSublayerTransform(transform)

      textLabel.layer.anchorPoint = CGPointMake(0.5, 1.0)
      textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight

      self.selectionStyle = UITableViewCellSelectionStyleNone

      self.tintColor = UIColor.whiteColor
    end
    self
  end

  def layoutSubviews
    super

    fraction = self.frame.size.height / @finishedHeight.to_f
    fraction = [[1, fraction].min, 0].max

    angle = (Math::PI / 2) - Math.asin(fraction)
    transform = CATransform3DMakeRotation(angle, 1, 0, 0)
    textLabel.layer.setTransform(transform)

    textLabel.backgroundColor = tintColor.with_brightness(0.3 + 0.7*fraction)

    contentViewSize = self.contentView.frame.size
    labelHeight = @finishedHeight

    self.textLabel.frame = [[0, contentViewSize.height - labelHeight], [contentViewSize.width, labelHeight]]
  end
end
