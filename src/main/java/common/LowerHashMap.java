package common;

import org.springframework.jdbc.support.JdbcUtils;

import java.util.HashMap;

public class LowerHashMap extends HashMap {
    @Override
    public Object put(Object key, Object value) {
        if(value == null){
            value = "";
        }
        return super.put(JdbcUtils.convertUnderscoreNameToPropertyName((String) key), value);
    }
}
