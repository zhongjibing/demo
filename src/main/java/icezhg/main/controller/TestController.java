package icezhg.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by zhongjibing on 2016/10/21.
 */
@Controller
@RequestMapping(value = "/test")
public class TestController {

    private static final Logger LOG = LoggerFactory.getLogger(TestController.class);

    @RequestMapping(value = "/hello")
    public String helloworld(Model model) {
        LOG.info("[TestController] request recived.");
        model.addAttribute("message", "this is a test");
        return "index";
    }
}
