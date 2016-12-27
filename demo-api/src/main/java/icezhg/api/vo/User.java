package icezhg.api.vo;

import java.io.Serializable;

/**
 * Created by zhongjibing on 2016/12/28.
 */
public class User implements Serializable {
    private static final long serialVersionUID = -358929520254516377L;

    private int id;
    private String name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "{\"id\":" + id + ", \"name\":\"" + name + "\"}";
    }
}
