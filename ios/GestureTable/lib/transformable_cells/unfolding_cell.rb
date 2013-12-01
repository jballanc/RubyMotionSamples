class UnfoldingTableViewCell < UITableViewCell
  include TransformableTableViewCell

  def initialize(reuse_id, target_height)
    self.initWithStyle(UITableViewCellStyleSubtitle,
                       reuseIdentifier: reuse_id)

    transform = CATransform3DIdentity
    transform.m34 = -1 / 500.to_f
    contentView.layer.setSublayerTransform(transform)

    self.selectionStyle = UITableViewCellSelectionStyleNone
    self.tintColor = UIColor.whiteColor

    @label_rotator = TextLabelRotator.new([textLabel, detailTextLabel], target_height)
  end

  def layoutSubviews
    super
    @label_rotator.height = self.frame.size.height
  end
end

