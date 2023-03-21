# resource "kubernetes_namespace" "monitoring" {
#   metadata {
#     labels = {
#       app = "monitoring"
#     }

#     name = "monitoring"
#   }

#   depends_on = [
#     helm_release.linkerd_control_plane
#   ]
# }
