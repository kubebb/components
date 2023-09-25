# Do `rating` with AI

This example shows how to do `Rating` on a component with the help of AI as the evaluator.

In `rating_with_ai.yaml`,we applied 3 resources:

- k8s Secret `zhipuai` which contains authentication info for LLM `zhipuai`
- kubeagi/arcadia LLM `zhipuai` which contains access info to call a llm. See [here](https://github.com/kubeagi/arcadia#arcadia) for more details
- kubebb Rating `rating-with-ai` which contains configurations on how to do a Rating. See [here](https://kubebb.github.io/website/docs/core/concepts/rating) for more details.


## Prerequisites

1. Enable Rating in kubebb/core
`Rating` is disabled by default in kubebb/core. To enable `Rating` in kubebb,please refer to [Enable Rating](https://kubebb.github.io/website/docs/core/userguide/enablerating) which installs 
- [Tekton](https://tekton.dev/) 
- [KubeAGI Arcadia](https://github.com/kubeagi/arcadia) 

prior to enable rating.

2. Apply a APIKey from [ZhiPuAI](https://open.bigmodel.cn/)

## Usage
Please follow the below steps to run a AI Rating!❤️ 

### Update apiKey in llm auth secret

1. Encode the apikey which has been retried from [ZhiPuAI](https://open.bigmodel.cn/)

```shell
❯ echo -n fed0965bce0190ff2bc681ac306d5f3d.eIp7sOXrnxmWJxOk  | base64 -b 0
ZmVkMDk2NWJjZTAxOTBmZjJiYzY4MWFjMzA2ZDVmM2QuZUlwN3NPWHJueG1XSnhPaw==
```

2. Replace `data.apiKey` in auth secret `zhipuai` in `rating_with_ai.yaml`

### Apply this `Rating` along with a `secret` and a `llm`

```shell
kubectl apply -f rating_with_ai.yaml
```


### Check `Rating` status

1. Use below command to get `rating`.

```shell
kubectl get ratings -nkubebb-system rating-with-ai -oyaml
```

Once rating finished,you should get below output:

```yaml
apiVersion: core.kubebb.k8s.com.cn/v1alpha1
kind: Rating
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"core.kubebb.k8s.com.cn/v1alpha1","kind":"Rating","metadata":{"annotations":{},"name":"rating-with-ai","namespace":"kubebb-system"},"spec":{"componentName":"kubebb.kubebb-core","evaluator":{"llm":"zhipuai"},"pipelineParams":[{"dimension":"reliability","params":[{"name":"URL","value":{"arrayVal":[],"objectVal":{},"stringVal":"https://github.com/kubebb/components/releases/download/kubebb-core-v0.1.10/kubebb-core-v0.1.10.tgz","type":"string"}},{"name":"COMPONENT_NAME","value":{"stringVal":"kubebb.kubebb-core","type":"string"}},{"name":"VERSION","value":{"stringVal":"v0.1.10","type":"string"}},{"name":"REPOSITORY_NAME","value":{"stringVal":"kubebb","type":"string"}}],"pipelineName":"kubebb-core-reliability"},{"dimension":"security","params":[{"name":"URL","value":{"arrayVal":[],"objectVal":{},"stringVal":"https://github.com/kubebb/components/releases/download/kubebb-core-v0.1.10/kubebb-core-v0.1.10.tgz","type":"string"}},{"name":"COMPONENT_NAME","value":{"stringVal":"kubebb-core","type":"string"}},{"name":"VERSION","value":{"stringVal":"v0.1.10","type":"string"}},{"name":"REPOSITORY_NAME","value":{"stringVal":"kubebb","type":"string"}}],"pipelineName":"kubebb-core-security"}]}}
  creationTimestamp: "2023-09-13T03:29:47Z"
  generation: 2
  labels:
    rating.component: kubebb.kubebb-core
    rating.repository: kubebb
  name: rating-with-ai
  namespace: kubebb-system
  resourceVersion: "9434"
  uid: c5a278a9-0212-4ce3-b100-94d6d60b62f9
spec:
  componentName: kubebb.kubebb-core
  evaluator:
    llm: zhipuai
  pipelineParams:
  - dimension: reliability
    params:
    - name: URL
      value:
        stringVal: https://github.com/kubebb/components/releases/download/kubebb-core-v0.1.10/kubebb-core-v0.1.10.tgz
        type: string
    - name: COMPONENT_NAME
      value:
        stringVal: kubebb.kubebb-core
        type: string
    - name: VERSION
      value:
        stringVal: v0.1.10
        type: string
    - name: REPOSITORY_NAME
      value:
        stringVal: kubebb
        type: string
    pipelineName: kubebb-core-reliability
  - dimension: security
    params:
    - name: URL
      value:
        stringVal: https://github.com/kubebb/components/releases/download/kubebb-core-v0.1.10/kubebb-core-v0.1.10.tgz
        type: string
    - name: COMPONENT_NAME
      value:
        stringVal: kubebb-core
        type: string
    - name: VERSION
      value:
        stringVal: v0.1.10
        type: string
    - name: REPOSITORY_NAME
      value:
        stringVal: kubebb
        type: string
    pipelineName: kubebb-core-security
status:
  evaluations:
    reliability:
      conditions:
      - lastTransitionTime: "2023-09-13T03:31:51Z"
        message: Finished CallLLM
        reason: ReconcileSuccess
        status: "True"
        type: Done
      prompt: rating-with-ai-reliability
    security:
      conditions:
      - lastTransitionTime: "2023-09-13T03:31:58Z"
        message: Finished CallLLM
        reason: ReconcileSuccess
        status: "True"
        type: Done
      prompt: rating-with-ai-security
  pipelineRuns:
    reliability:
      conditions:
      - lastTransitionTime: "2023-09-13T03:31:46Z"
        message: 'Tasks Completed: 1 (Failed: 0, Cancelled 0), Skipped: 0'
        reason: Succeeded
        status: "True"
        type: Succeeded
      pipelineName: kubebb-core-reliability
      pipelinerunName: rating-with-ai.reliability
      tasks:
      - conditions:
        - lastTransitionTime: "2023-09-13T03:31:46Z"
          message: All Steps have completed executing
          reason: Succeeded
          status: "True"
          type: Succeeded
        description: ""
        name: kubebb-core-helm-lint
        taskRunName: rating-with-ai.reliability-kubebb-core-helm-lint
    security:
      conditions:
      - lastTransitionTime: "2023-09-13T03:31:47Z"
        message: 'Tasks Completed: 1 (Failed: 0, Cancelled 0), Skipped: 0'
        reason: Succeeded
        status: "True"
        type: Succeeded
      pipelineName: kubebb-core-security
      pipelinerunName: rating-with-ai.security
      tasks:
      - conditions:
        - lastTransitionTime: "2023-09-13T03:31:47Z"
          message: All Steps have completed executing
          reason: Succeeded
          status: "True"
          type: Succeeded
        description: ""
        name: kubebb-core-rback
        taskRunName: rating-with-ai.security-kubebb-core-rback
```

2. Get AI `Prompts` for this rating

In `status.evaluations`, you can get the AI Evaluation results and the relevant `Prompt` resource. 

For this rating ,it contains two `Prompt` resouces 

- `rating-with-ai-reliability` in same namespace `kubebb-system`
- `rating-with-ai-security` in same namespace `kubebb-system`

Get the prompts data with below command:

```shell
# get reliability rating data
kubectl get prompt -nkubebb-system rating-with-ai-reliability --output="jsonpath={.status.data}" | base64 --decode
# get secruity rating data
kubectl get prompt -nkubebb-system rating-with-ai-security --output="jsonpath={.status.data}" | base64 --decode
```

Output:

```shell
❯ kubectl get prompt -nkubebb-system rating-with-ai-reliability --output="jsonpath={.status.data}" | base64 --decode
{"code":200,"data":{"request_id":"7927723993030545966","task_id":"7927723993030545966","task_status":"SUCCESS","usage":{"total_tokens":183},"choices":[{"content":"\" Based on the information provided, the component has gone through two tests with two different ratings. The first test was a linting tool test with a rating of Succeeded All Steps Completed, while the second test was a rating-with-AI test with a rating of Succeeded True.\\n\\nBased on the provided information, there are no potential reliability risks that would arise from adopting this component in production. The component has passed both of its tests, indicating that it has met the required reliability standards.\\n\\nBased on the provided information, I would rate the reliability of this component as a 9 out of 10. The component has passed both of its tests, indicating that it has met the required reliability standards. However, it is important to note that this is based on the information provided and additional research may be necessary to fully assess the reliability of the component in production.\"","role":"assistant"}]},"msg":"操作成功","success":true}%
❯ kubectl get prompt -nkubebb-system rating-with-ai-security --output="jsonpath={.status.data}" | base64 --decode
{"code":200,"data":{"request_id":"7927723993030537787","task_id":"7927723993030537787","task_status":"SUCCESS","usage":{"total_tokens":257},"choices":[{"content":"\" Based on the information provided, the component has gone through two security tests with positive results. However, there are still potential security risks that need to be addressed before the component can be deployed into production.\\n\\nHere are some potential risks that should be considered:\\n\\n1. Injection: There is a risk of injection attacks if the component does not properly handle user input. This could lead to the compromise of the system or the application.  \\n2. Authentication and Authorization: The component should have proper authentication and authorization mechanisms in place to ensure that only authorized users can access the system or the application.  \\n3. Logging and Tracing: The component should have proper logging and tracing mechanisms in place to track user activity and system events. This will help in identifying and responding to security incidents.  \\n4. Data Privacy: The component should ensure that any data it collects is compliant with data privacy regulations.  \\n5. Security of the Helm Chart: The component should be tested for vulnerabilities in the Helm chart used to deploy the component.\\n\\nBased on the above risks, I would rate the security of this component as a 6 out of 10. It has potential risks that need to be addressed before it can be deployed into production.\"","role":"assistant"}]},"msg":"操作成功","success":true}%
```

