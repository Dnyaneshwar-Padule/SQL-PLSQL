
CREATE OR REPLACE FUNCTION can_vote(age in int) 
RETURNS boolean AS $$
BEGIN 
    if age >= 18 then
        raise notice 'Candidate can vote !';
        return true;
    else 
        raise notice 'Candidate cann''t vote';
        return false;
    end if;
END;
$$ LANGUAGE 'plpgsql';
