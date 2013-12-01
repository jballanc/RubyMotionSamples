class TextLabelRotator
  def initialize(label, target_height, direction = :up)
    @label = label
    @target_height = target_height
    @direction = direction
    @height = 0

    label.layer.anchorPoint = CGPointMake(0.5, 1.0)
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight
  end

  def height=(height)
    @height = height
    rotate
    adjust_brightness
    resize_frame
  end


  private

  def rotate
    angle = (Math::PI / 2) - Math.asin(vis_fract)
    transform = CATransform3DMakeRotation(angle, 1, 0, 0)
    @label.layer.setTransform(transform)
  end

  def adjust_brightness
    tint_color = @label.superview.tintColor
    @label.backgroundColor = tint_color.with_brightness(0.3 + 0.7 * vis_fract)
  end

  def resize_frame
    parent_size = @label.superview.frame.size
    @label.frame = [[0, parent_size.height - @target_height],
                    [parent_size.width, @target_height]]
  end

  def vis_fract
    frac = @height / @target_height.to_f
    [[1, frac].min, 0].max
  end
end
