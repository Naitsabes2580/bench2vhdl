class vhdl_generic:
  def __init__(self, name, type, std_value):
      self.name = name
      self.type = type
      self.std_value = std_value
      
class vhdl_port:
  def __init__(self, name, port_direction, port_type):#, std_value):
      self.name = name
      self.direction = port_direction
      self.type = port_type
      #self.std_value = std_value

  def writeEntityPortDeclaration(self):
    rts = '%s: %s %s;\n' % (self.name,self.direction,self.type)
    return rts

class vhdl_component:
  def __init__(self, name, generics, inputs, outputs):
    self.name = name
    self.generics = generics
    self.inputs = inputs
    self.outputs = outputs

  def writeComponentDeclaration(self):
    rts = '\tcomponent %s\n' % self.name
    if len(self.generics) != 0:
      rts += '\t\tgeneric (\n'
      for i in range(0,len(self.generics)-1):
        rts += '\t\t\t%s : %s : %s;\n' % (self.generics[i].name, self.generics[i].type, self.generics[i].std_value)
      rts += '\t\t\t%s : %s : %s\n\t\t);' % (self.generics[-1].name, self.generics[-1].type, self.generics[-1].std_value)
    if not(len(self.inputs) == 0 or len(self.outputs) == 0):
      rts += '\n\t\tport (\n'
    if len(self.inputs) != 0:      
      for i in range(0,len(self.inputs)):
        rts += '\t\t\t%s : %s : %s;\n' % (self.inputs[i].name, self.inputs[i].direction, self.inputs[i].type)
    if len(self.outputs) != 0:      
      for i in range(0,len(self.inputs)-2):
        rts += '\t\t\t%s : %s : %s;\n' % (self.outputs[i].name, self.outputs[i].direction, self.outputs[i].type)
      rts += '\t\t\t%s : %s : %s\n\t\t);' % (self.outputs[-1].name, self.outputs[-1].direction, self.outputs[-1].type)
    rts += '\n\tend component;\n'  
    return rts

class vhdl_entity:
   

   def __init__(self, entityname, generics, inputs, outputs):
      self.entityname = entityname
      self.generics = generics
      self.inputs = inputs
      self.outputs = outputs               

   def writeEmptyEntity(self):
     rts = 'entity %s is\nend;\n' % self.entityname
     return rts

   #def writeEntityDeclaration(self):
   #  rts = 'entity %s is\nend;\n' % self.entityname
   #  return rts

   # def writeEntityAsComponent(self):
   #   rts = 'component %s \n' % self.entityname
   #   if len(self.generics) != 0:
   #    rts = rts + 'generic (\n'
   #    for i in range(0, len(self.generics)-1): 
   #      new_generic = ('%s : %s : %s;\n' % (self.generics(i).name, (self.generics(i).type, (self.generics(i).std_value))
   #      rts = rts + new_generic
   #    last = len(self.generics)    
   #    rts = rts + ('%s : %s : %s;\n' % (self.generics(last).name, (self.generics(last).type, (self.generics(last).std_value))
   #   if len(self.inputs) != 0 and len(self.outputs) != 0
   #    rts += 'port (\n'
   #    for i in range(0, len(self.inputs)):
   #      rts += '%s : %s : %s;\n' % (self.inputs(i).name, (self.inputs(i).type, (self.inputs(i).std_value)
   #    for i in range(0, len(self.outputs)-1):
   #      rts += '%s : %s : %s;\n' % (self.outputs(i).name, (self.outputs(i).type, (self.outputs(i).std_value)
   #    rts += '%s : %s : %s);\n' % (self.outputs(-1).name, (self.outputs(-1).type, (self.outputs(-1).std_value)
   #   rts += 'end component;\n'
   #   return rts