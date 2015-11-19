module "static" {

    source = "./static"

    # Variables from variables.tf
    region = "${var.region}"
    aws_access_key_id = "${var.aws_access_key_id}"
    aws_secret_access_key = "${var.aws_secret_access_key}"

}

/* BLUE (Prefix with # to ENABLE, leave as /* to DISABLE)
module "blue" {

    web_ami_id = "" # Get from Packer

    source = "./blue-green"
    blue_green_value = "blue"

    # Pass outputs from static module as variables to blue-green module
    aws_elb_lb_id = "${module.static.aws_elb_lb_id}"
    aws_subnet_web_a_id = "${module.static.aws_subnet_web_a_id}"
    aws_subnet_web_b_id = "${module.static.aws_subnet_web_b_id}"
    aws_security_group_web_id = "${module.static.aws_security_group_web_id}"
    aws_sns_topic_auto_scaling_arn = "${module.static.aws_sns_topic_auto_scaling_arn}"

}
/**/

#/* GREEN (Prefix with # to ENABLE, leave as /* to DISABLE)
module "green" {

    web_ami_id = "ami-5d1c5f67" # Get from Packer

    source = "./blue-green"
    blue_green_value = "green"

    # Pass outputs from static module as variables to blue-green module
    aws_elb_lb_id = "${module.static.aws_elb_lb_id}"
    aws_subnet_web_a_id = "${module.static.aws_subnet_web_a_id}"
    aws_subnet_web_b_id = "${module.static.aws_subnet_web_b_id}"
    aws_security_group_web_id = "${module.static.aws_security_group_web_id}"
    aws_sns_topic_auto_scaling_arn = "${module.static.aws_sns_topic_auto_scaling_arn}"

}
/**/