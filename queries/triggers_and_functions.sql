-- Function to validate order timeline consistency

CREATE OR REPLACE FUNCTION validate_order_timeline()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.shipped_at IS NOT NULL
       AND NEW.shipped_at < NEW.created_at THEN
        RAISE EXCEPTION 'Shipped date cannot be earlier than created date';
    END IF;

    IF NEW.delivered_at IS NOT NULL
       AND NEW.shipped_at IS NOT NULL
       AND NEW.delivered_at < NEW.shipped_at THEN
        RAISE EXCEPTION 'Delivered date cannot be earlier than shipped date';
    END IF;

    IF NEW.returned_at IS NOT NULL
       AND NEW.delivered_at IS NOT NULL
       AND NEW.returned_at < NEW.delivered_at THEN
        RAISE EXCEPTION 'Returned date cannot be earlier than delivered date';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trg_validate_order_timeline ON orders;

CREATE TRIGGER trg_validate_order_timeline
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION validate_order_timeline();