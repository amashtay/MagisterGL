//
//  Scene.swift
//  MagisterGL
//
//  Created by Хохлова Татьяна on 11.06.17.
//  Copyright © 2017 Хохлова Татьяна. All rights reserved.
//


import OpenGLES


let NUM_LIGHTS = 3

class Scene
{
  fileprivate var program: ShaderProgram
  fileprivate var programProjectionMatrixLocation: GLuint
  fileprivate var programModelviewMatrixLocation: GLuint
  fileprivate var programCameraPositionLocation: GLuint
  fileprivate var programLightPositionLocation: GLuint
  fileprivate var programLightColorLocation: GLuint
  
  fileprivate var lightPosition = [Float](repeating: 0.0, count: NUM_LIGHTS * 3)
  fileprivate var lightColor: [Float] = [1.0, 0.0, 0.0,
                                         0.0, 1.0, 0.0,
                                         0.0, 0.0, 1.0]
  fileprivate var lightRotation: Float = 0.0
  
  fileprivate var normalmap: Texture?
  fileprivate var renderables: [Renderable]
  
  fileprivate var cameraRotation: Float = 0.0
  fileprivate var cameraPosition: [Float] = [0.0, 0.0, 4.0]
  
  init()
  {
    // Create the program, attach shaders, and link.
    program = ShaderProgram()
    program.attachShader("shader.vs", withType: GL_VERTEX_SHADER)
    program.attachShader("shader.fs", withType: GL_FRAGMENT_SHADER)
    program.link()
    
    // Get uniform locations.
    programProjectionMatrixLocation = program.getUniformLocation("projectionMatrix")!
    programModelviewMatrixLocation = program.getUniformLocation("modelviewMatrix")!
    programCameraPositionLocation = program.getUniformLocation("cameraPosition")!
    programLightPositionLocation = program.getUniformLocation("lightPosition")!
    programLightColorLocation = program.getUniformLocation("lightColor")!
    
    normalmap = Texture.loadFromFile("normalmap.png")
    renderables = [Cube(program: program),
                   Cylinder(program: program, numberOfDivisions: 3)]
  }
  
  func render(_ projectionMatrix: Matrix4)
  {
    // Render the object.
    for renderable in renderables
    {
      var translationMatrix = Matrix4.translationMatrix(x: -cameraPosition[0],
                                                        y: -cameraPosition[1],
                                                        z: -cameraPosition[2])
      if renderable is Cube
      {
        translationMatrix = Matrix4.translationMatrix(x: -cameraPosition[0] + 1,
                                                      y: -cameraPosition[1],
                                                      z: -cameraPosition[2])
      }
      let rotationMatrix = Matrix4.rotationMatrix(angle: cameraRotation,
                                                  x: 0.0,
                                                  y: -1.0,
                                                  z: 0.0)
      let modelviewMatrix = translationMatrix * rotationMatrix
      
      // Enable the program and set uniform variables.
      program.use()
      glUniformMatrix4fv(GLint(programProjectionMatrixLocation), 1, GLboolean(GL_FALSE), UnsafePointer<GLfloat>(projectionMatrix.matrix))
      glUniformMatrix4fv(GLint(programModelviewMatrixLocation), 1, GLboolean(GL_FALSE), UnsafePointer<GLfloat>(modelviewMatrix.matrix))
      glUniform3fv(GLint(programCameraPositionLocation), 1, UnsafePointer<GLfloat>(cameraPosition))
      glUniform3fv(GLint(programLightPositionLocation), GLint(NUM_LIGHTS), UnsafePointer<GLfloat>(lightPosition))
      glUniform3fv(GLint(programLightColorLocation), GLint(NUM_LIGHTS), UnsafePointer<GLfloat>(lightColor))
      renderable.render()
      
      // Disable the program.
      glUseProgram(0)
    }
  }
  
  func cycle(_ secondsElapsed: Float)
  {
    // Update the light positions.
    lightRotation += (M_PI_F / 4.0) * secondsElapsed
    for i in 0..<NUM_LIGHTS
    {
      let radius: Float = 1.75
      let r = (((M_PI_F * 2.0) / Float(NUM_LIGHTS)) * Float(i)) + lightRotation
      
      lightPosition[i * 3 + 0] = cosf(r) * radius
      lightPosition[i * 3 + 1] = cosf(r) * sinf(r)
      lightPosition[i * 3 + 2] = sinf(r) * radius
    }
    
    // Update the camera position.
    cameraRotation -= (M_PI_F / 16.0) * secondsElapsed
    cameraPosition[0] = sinf(cameraRotation) * 4.0
    cameraPosition[1] = 0.0
    cameraPosition[2] = cosf(cameraRotation) * 4.0
  }
}
