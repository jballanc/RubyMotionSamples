class UnfoldingTableViewCell < UITableViewCell
  include TransformableTableViewCell

  def initialize(reuseIdentifier)
    if self.initWithStyle(UITableViewCellStyleSubtitle,
                          reuseIdentifier: reuseIdentifier)
      transform = CATransform3DIdentity
      transform.m34 = -1 / 500.to_f
      contentView.layer.setSublayerTransform(transform)

      textLabel.layer.anchorPoint = CGPointMake(0.5, 0.0)
      detailTextLabel.layer.anchorPoint = CGPointMake(0.5, 1.0)

      textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight
      detailTextLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight

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
    transform = CATransform3DMakeRotation(angle, -1, 0, 0)
    textLabel.layer.setTransform(transform)
    detailTextLabel.layer.setTransform(CATransform3DMakeRotation(angle, 1, 0, 0))

    textLabel.backgroundColor = tintColor.with_brightness(0.3 + 0.7*fraction)
    detailTextLabel.backgroundColor = tintColor.with_brightness(0.5 + 0.5*fraction)

    contentViewSize = contentView.frame.size
    contentViewMidY = contentViewSize.height / 2.0
    labelHeight = @finishedHeight / 2.0

    textLabel.frame = [[0, contentViewMidY - (labelHeight * fraction)], [contentViewSize.width, labelHeight + 1]]
    detailTextLabel.frame = [[0, contentViewMidY - (labelHeight * (1 - fraction))], [contentViewSize.width, labelHeight]]
  end
end

