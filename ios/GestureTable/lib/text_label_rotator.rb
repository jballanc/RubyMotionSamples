class TextLabelRotator
  def initialize(labels, target_height)
    if labels.is_a? Array
      @top_label, @label = labels
    else
      @label = labels
    end
    @target_height = target_height
    @height = 0

    @label.layer.anchorPoint = CGPointMake(0.5, 1.0)
    @label.autoresizingMask = UIViewAutoresizingFlexibleHeight
    if @top_label
      @top_label.layer.anchorPoint = CGPointMake(0.5, 0.0)
      @label.autoresizingMask = UIViewAutoresizingFlexibleHeight
    end
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
    @label.layer.setTransform(CATransform3DMakeRotation(angle, 1, 0, 0))

    @top_label.layer
              .setTransform(CATransform3DMakeRotation(angle, -1, 0, 0)) if @top_label
  end

  def adjust_brightness
    tint = @label.superview.tintColor
    @label.backgroundColor = tint.with_brightness(0.3 + 0.7 * vis_fract)
    @top_label.backgroundColor = tint.with_brightness(0.5 + 0.5 * vis_fract) if @top_label
  end

  def resize_frame
    parent_size = @label.superview.frame.size
    if @top_label
      label_height = @target_height / 2.0
      mid_y = @label.superview.frame.size.height / 2.0
      @label.frame = [[0, mid_y - (label_height * (1 - vis_fract))],
                      [parent_size.width, label_height]]
      @top_label.frame = [[0, mid_y - (label_height * vis_fract)],
                          [parent_size.width, label_height + 1]]
    else
      @label.frame = [[0, parent_size.height - @target_height],
                      [parent_size.width, @target_height]]
    end
  end

  def vis_fract
    frac = @height / @target_height.to_f
    [[1, frac].min, 0].max
  end
end
